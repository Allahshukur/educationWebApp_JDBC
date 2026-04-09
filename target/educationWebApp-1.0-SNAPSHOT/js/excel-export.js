let _ctx = { tableId: null, title: null, filename: null, total: 0, allData: null };
let _fmt = null;
let _lastTrigger = null;
let _pdfFontPromise = null;

const LABELS = {
    noData: 'Export edil\u0259c\u0259k m\u0259lumat yoxdur.',
    excelMissing: 'Excel kitabxanasi yuklenmeyib. Sehifeni yeniden acin.',
    excelNotFound: 'Excel kitabxanasi tapilmadi. Sehifeni yeniden acin.',
    pdfMissing: 'PDF kitabxanasi hele yuklenmeyib, bir az gozleyin.',
    excelOk: count => `Excel yuklendi - ${count} setir`,
    wordOk: count => `Word yuklendi - ${count} setir`,
    pdfOk: count => `PDF yuklendi - ${count} setir`,
    exportDate: () => `\u0130xrac tarixi: ${new Date().toLocaleString('az-AZ')}  |  Education App`
};

window.openExportModal = function(tableId, title, filename, total, allData) {
    _ctx = { tableId, title, filename, total: total || 0, allData: allData || null };
    _fmt = null;
    _lastTrigger = document.activeElement instanceof HTMLElement ? document.activeElement : null;
    _showStep(1);
    bootstrap.Modal.getOrCreateInstance(document.getElementById('exportModal')).show();
};

window.openExcelExportModal = window.openExportModal;

function _showStep(step) {
    document.getElementById('exportStep1').style.display = step === 1 ? '' : 'none';
    document.getElementById('exportStep2').style.display = step === 2 ? '' : 'none';

    if (step !== 2) return;

    const table = document.getElementById(_ctx.tableId);
    const visibleCount = table
        ? table.querySelectorAll('tbody tr:not([style*="display: none"]):not(.d-none)').length
        : 0;
    const allCount = (_ctx.total && _ctx.total > 0)
        ? _ctx.total
        : (_ctx.allData && Array.isArray(_ctx.allData.dataRows) ? _ctx.allData.dataRows.length : 0);

    document.getElementById('exportVisibleCount').textContent = visibleCount;
    document.getElementById('exportAllCount').textContent = allCount || '-';
    document.getElementById('exportFmtLabel').textContent = _fmtName(_fmt);
    document.getElementById('exportFmtIcon').className = _fmtIcon(_fmt);
}

const _fmtName = fmt => ({
    excel: 'Excel (.xlsx)',
    word: 'Word (.doc)',
    pdf: 'PDF'
}[fmt] || '');

const _fmtIcon = fmt => ({
    excel: 'bi bi-file-earmark-excel-fill text-success me-2',
    word: 'bi bi-file-earmark-word-fill text-primary me-2',
    pdf: 'bi bi-file-earmark-pdf-fill text-danger me-2'
}[fmt] || 'bi bi-file-earmark me-2');

document.addEventListener('DOMContentLoaded', () => {
    const modalEl = document.getElementById('exportModal');

    document.getElementById('fmtExcelBtn').addEventListener('click', () => {
        _fmt = 'excel';
        _showStep(2);
    });
    document.getElementById('fmtWordBtn').addEventListener('click', () => {
        _fmt = 'word';
        _showStep(2);
    });
    document.getElementById('fmtPdfBtn').addEventListener('click', () => {
        _fmt = 'pdf';
        _showStep(2);
    });
    document.getElementById('exportBackBtn').addEventListener('click', () => _showStep(1));
    document.getElementById('exportVisibleBtn').addEventListener('click', () => {
        _closeModal();
        _doExport(false);
    });
    document.getElementById('exportAllBtn').addEventListener('click', () => {
        _closeModal();
        _doExport(true);
    });

    modalEl.addEventListener('hide.bs.modal', () => {
        if (modalEl.contains(document.activeElement)) {
            document.activeElement.blur();
        }
    });

    modalEl.addEventListener('hidden.bs.modal', () => {
        if (_lastTrigger && document.body.contains(_lastTrigger)) {
            _lastTrigger.focus();
        }
    });
});

function _closeModal() {
    const modalEl = document.getElementById('exportModal');
    if (modalEl.contains(document.activeElement)) {
        document.activeElement.blur();
    }
    bootstrap.Modal.getInstance(modalEl)?.hide();
}

function _collectData(tableId, allRows) {
    const table = document.getElementById(tableId);
    if (!table) return null;

    const exportColumns = _getVisibleExportColumns(table);
    const headers = exportColumns.map(column => column.label);

    const rowSelector = allRows
        ? 'tbody tr'
        : 'tbody tr:not([style*="display: none"]):not(.d-none)';

    const dataRows = Array.from(table.querySelectorAll(rowSelector))
        .filter(tr => !tr.querySelector('.empty-state, [colspan]'))
        .map(tr => exportColumns.map(column => {
            if (column.tableIndex < 0) {
                if (column.label === 'Email') return _cleanText(tr.dataset.exportEmail || '');
                return '';
            }
            const td = tr.children[column.tableIndex];
            return _cleanText(td ? (td.dataset.export || td.textContent) : '');
        }))
        .filter(row => row.length);

    return { headers, dataRows };
}

function _doExport(allRows) {
    const data = allRows && _ctx.allData
        ? _preparePrebuiltData(_ctx.allData, _ctx.tableId)
        : _collectData(_ctx.tableId, allRows);
    if (!data || !data.dataRows.length) {
        showAppToast(LABELS.noData, 'warning');
        return;
    }

    ({ excel: _exportExcel, word: _exportWord, pdf: _exportPdf }[_fmt] || (() => {}))(data);
}

function _exportExcel({ headers, dataRows }) {
    const ExcelJS = window.ExcelJS;
    if (!ExcelJS && window.XLSX) {
        _exportExcelWithSheetJS({ headers, dataRows });
        return;
    }
    if (!ExcelJS) {
        showAppToast(LABELS.excelMissing, 'danger');
        return;
    }

    const workbook = new ExcelJS.Workbook();
    const worksheet = workbook.addWorksheet((_ctx.title || 'Siyahi').substring(0, 31));
    const lastColumn = _excelColumnName(headers.length);

    worksheet.columns = headers.map((header, index) => ({
        key: `col${index}`,
        width: Math.min(
            Math.max(
                String(header || '').length + 2,
                ...(dataRows.length ? dataRows.map(row => String(row[index] || '').length + 2) : [10])
            ),
            50
        )
    }));

    worksheet.insertRow(1, [_ctx.title || 'Siyahi']);
    worksheet.insertRow(2, [LABELS.exportDate()]);
    worksheet.insertRow(3, []);
    worksheet.insertRow(4, headers);

    worksheet.mergeCells(`A1:${lastColumn}1`);
    worksheet.mergeCells(`A2:${lastColumn}2`);

    worksheet.getCell('A1').font = { bold: true, size: 16, color: { argb: 'FF4F46E5' }, name: 'Calibri' };
    worksheet.getCell('A1').alignment = { horizontal: 'left', vertical: 'center' };
    worksheet.getCell('A2').font = { size: 9, color: { argb: 'FF6B7280' }, name: 'Calibri' };
    worksheet.getCell('A2').alignment = { horizontal: 'left', vertical: 'center' };

    const headerRow = worksheet.getRow(4);
    headerRow.eachCell({ includeEmpty: false }, cell => {
        cell.font = { bold: true, size: 11, color: { argb: 'FFFFFFFF' }, name: 'Calibri' };
        cell.fill = { type: 'pattern', pattern: 'solid', fgColor: { argb: 'FF4F46E5' } };
        cell.alignment = { horizontal: 'center', vertical: 'center' };
        cell.border = _mediumBorder('FF3730A3');
    });

    dataRows.forEach((row, rowIndex) => {
        const excelRow = worksheet.insertRow(5 + rowIndex, row);
        const fillArgb = rowIndex % 2 === 0 ? 'FFFFFFFF' : 'FFEEF2FF';
        excelRow.eachCell({ includeEmpty: false }, cell => {
            cell.font = { size: 10, color: { argb: 'FF1E1B4B' }, name: 'Calibri' };
            cell.fill = { type: 'pattern', pattern: 'solid', fgColor: { argb: fillArgb } };
            cell.alignment = { vertical: 'center' };
            cell.border = _thinBorder('FFC7D2FE');
        });
    });

    worksheet.getRow(1).height = 30;
    worksheet.getRow(2).height = 16;
    worksheet.getRow(3).height = 8;
    worksheet.getRow(4).height = 22;

    workbook.xlsx.writeBuffer().then(buffer => {
        const blob = new Blob([buffer], {
            type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
        });
        _download(blob, `${_safeName()}_${_date()}.xlsx`);
        showAppToast(LABELS.excelOk(dataRows.length), 'success');
    }).catch(error => {
        console.error('Excel export error:', error);
        showAppToast(LABELS.excelMissing, 'danger');
    });
}

function _exportExcelWithSheetJS({ headers, dataRows }) {
    const XLSX = window.XLSX;
    if (!XLSX) {
        showAppToast(LABELS.excelNotFound, 'danger');
        return;
    }

    const aoa = [
        [_ctx.title || 'Siyahi'],
        [LABELS.exportDate()],
        [],
        headers,
        ...dataRows
    ];

    const worksheet = XLSX.utils.aoa_to_sheet(aoa);
    const workbook = XLSX.utils.book_new();

    worksheet['!cols'] = headers.map((header, index) => ({
        wch: Math.min(
            Math.max(
                String(header || '').length + 2,
                ...(dataRows.length ? dataRows.map(row => String(row[index] || '').length + 2) : [10])
            ),
            50
        )
    }));

    if (headers.length > 0) {
        worksheet['!merges'] = [
            { s: { r: 0, c: 0 }, e: { r: 0, c: headers.length - 1 } },
            { s: { r: 1, c: 0 }, e: { r: 1, c: headers.length - 1 } }
        ];
    }

    XLSX.utils.book_append_sheet(workbook, worksheet, (_ctx.title || 'Siyahi').substring(0, 31));
    XLSX.writeFile(workbook, `${_safeName()}_${_date()}.xlsx`);
    showAppToast(LABELS.excelOk(dataRows.length), 'success');
}

function _exportWord({ headers, dataRows }) {
    const thCells = headers.map(header =>
        `<th style="background:#4F46E5;color:#fff;padding:8px 12px;border:1px solid #3730A3;font-size:11pt;text-align:center;font-family:Calibri,sans-serif;">${_escapeHtml(header)}</th>`
    ).join('');

    const tbRows = dataRows.map((row, rowIndex) => {
        const bg = rowIndex % 2 === 0 ? '#FFFFFF' : '#EEF2FF';
        const cells = row.map(value =>
            `<td style="padding:6px 12px;border:1px solid #C7D2FE;background:${bg};font-size:10pt;font-family:Calibri,sans-serif;">${_escapeHtml(value)}</td>`
        ).join('');
        return `<tr>${cells}</tr>`;
    }).join('');

    const html = `<!DOCTYPE html>
<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:w="urn:schemas-microsoft-com:office:word">
<head>
<meta charset="UTF-8">
<title>${_escapeHtml(_ctx.title || 'Siyahi')}</title>
<!--[if gte mso 9]><xml><w:WordDocument><w:View>Print</w:View><w:Zoom>90</w:Zoom><w:DoNotOptimizeForBrowser/></w:WordDocument></xml><![endif]-->
<style>
body{font-family:Calibri,sans-serif;margin:28px}
h2{color:#4F46E5;margin-bottom:2px;font-size:16pt}
p.sub{color:#6B7280;font-size:9pt;margin:0 0 14px}
table{border-collapse:collapse;width:100%}
</style>
</head>
<body>
<h2>${_escapeHtml(_ctx.title || 'Siyahi')}</h2>
<p class="sub">${_escapeHtml(LABELS.exportDate())}</p>
<table><thead><tr>${thCells}</tr></thead><tbody>${tbRows}</tbody></table>
</body>
</html>`;

    const blob = new Blob(['\uFEFF', html], { type: 'application/msword;charset=utf-8' });
    _download(blob, `${_safeName()}_${_date()}.doc`);
    showAppToast(LABELS.wordOk(dataRows.length), 'success');
}

async function _exportPdf({ headers, dataRows }) {
    const jsPDFCtor = (window.jspdf && window.jspdf.jsPDF) || window.jsPDF;
    if (!jsPDFCtor) {
        showAppToast(LABELS.pdfMissing, 'warning');
        return;
    }

    try {
        await _ensurePdfFonts(jsPDFCtor);
    } catch (error) {
        console.error('PDF font load error:', error);
        showAppToast('PDF ucun font yuklenmedi.', 'danger');
        return;
    }

    const doc = new jsPDFCtor({ orientation: 'landscape', unit: 'pt', format: 'a4' });

    doc.setFont('NotoSans', 'bold');
    doc.setFontSize(15);
    doc.setTextColor(79, 70, 229);
    doc.text(_cleanText(_ctx.title || 'Siyahi'), 40, 38);

    doc.setFont('NotoSans', 'normal');
    doc.setFontSize(8.5);
    doc.setTextColor(107, 114, 128);
    doc.text(_cleanText(LABELS.exportDate()), 40, 52);

    doc.setDrawColor(199, 210, 254);
    doc.setLineWidth(0.8);
    doc.line(40, 58, doc.internal.pageSize.width - 40, 58);

    doc.autoTable({
        head: [headers.map(_cleanText)],
        body: dataRows.map(row => row.map(_cleanText)),
        startY: 66,
        styles: {
            font: 'NotoSans',
            fontSize: 9,
            cellPadding: { top: 5, bottom: 5, left: 7, right: 7 },
            textColor: [30, 27, 75],
            lineColor: [199, 210, 254],
            lineWidth: 0.3
        },
        headStyles: {
            fillColor: [79, 70, 229],
            textColor: [255, 255, 255],
            fontStyle: 'bold',
            font: 'NotoSans',
            halign: 'center',
            fontSize: 9.5,
            cellPadding: { top: 7, bottom: 7, left: 7, right: 7 }
        },
        alternateRowStyles: { fillColor: [238, 242, 255] },
        bodyStyles: { fillColor: [255, 255, 255] },
        columnStyles: { 0: { halign: 'center' } },
        margin: { left: 40, right: 40 },
        didDrawPage: () => {
            const page = doc.internal.getCurrentPageInfo().pageNumber;
            const total = doc.internal.getNumberOfPages();
            doc.setFontSize(8);
            doc.setTextColor(156, 163, 175);
            doc.text(
                `Sehife ${page} / ${total}`,
                doc.internal.pageSize.width / 2,
                doc.internal.pageSize.height - 18,
                { align: 'center' }
            );
        }
    });

    doc.save(`${_safeName()}_${_date()}.pdf`);
    showAppToast(LABELS.pdfOk(dataRows.length), 'success');
}

function _ensurePdfFonts(jsPDFCtor) {
    if (_pdfFontPromise) return _pdfFontPromise;

    _pdfFontPromise = Promise.all([
        _fetchFontBase64((window.FONT_BASE_PATH || 'fonts/') + 'NotoSans-Regular.ttf'),
        _fetchFontBase64((window.FONT_BASE_PATH || 'fonts/') + 'NotoSans-Bold.ttf')
    ]).then(([regularFont, boldFont]) => {
        jsPDFCtor.API.events.push([
            'addFonts',
            function() {
                this.addFileToVFS('NotoSans-Regular.ttf', regularFont);
                this.addFont('NotoSans-Regular.ttf', 'NotoSans', 'normal');
                this.addFileToVFS('NotoSans-Bold.ttf', boldFont);
                this.addFont('NotoSans-Bold.ttf', 'NotoSans', 'bold');
            }
        ]);
    });

    return _pdfFontPromise;
}

async function _fetchFontBase64(url) {
    const response = await fetch(url);
    if (!response.ok) {
        throw new Error(`Font fetch failed: ${url}`);
    }

    const bytes = new Uint8Array(await response.arrayBuffer());
    let binary = '';
    const chunkSize = 0x8000;

    for (let i = 0; i < bytes.length; i += chunkSize) {
        binary += String.fromCharCode.apply(null, bytes.subarray(i, i + chunkSize));
    }

    return btoa(binary);
}

function _cleanText(value) {
    return String(value || '').replace(/\s+/g, ' ').trim();
}

function _getVisibleExportColumns(table) {
    const controls = _getExportControls(table);
    if (controls.length) {
        return controls
            .filter(control => control.checked)
            .map(control => ({
                tableIndex: control.tableIndex,
                exportIndex: control.exportIndex,
                label: control.label
            }));
    }

    return Array.from(table.querySelectorAll('thead th'))
        .map((th, tableIndex) => ({
            th,
            tableIndex,
            label: _cleanText(th.textContent)
        }))
        .filter(({ th, tableIndex }, _, columns) => {
            if (th.classList.contains('col-actions')) return false;
            if (tableIndex === columns.length - 1) return false;
            return !_isHidden(th);
        })
        .map(({ tableIndex, label }, exportIndex) => ({
            tableIndex,
            exportIndex,
            label
        }));
}

function _preparePrebuiltData(data, tableId) {
    const table = document.getElementById(tableId);
    if (!table || !data) return data;

    const exportColumns = _getVisibleExportColumns(table);
    const indexes = exportColumns.map(column => column.exportIndex);

    return {
        headers: indexes.map(index => _cleanText((data.headers || [])[index] || '')),
        dataRows: (data.dataRows || []).map(row => indexes.map(index => _cleanText((row || [])[index] || '')))
    };
}

function _isHidden(element) {
    if (!element) return true;
    return element.style.display === 'none' || window.getComputedStyle(element).display === 'none';
}

function _getExportControls(table) {
    const card = table.closest('.custom-table-card');
    if (!card) return [];

    return Array.from(card.querySelectorAll('.edu-col-chk, .edu-col-chk-t'))
        .filter(input => input.dataset.exportIndex !== undefined)
        .map(input => ({
            checked: input.checked,
            exportIndex: parseInt(input.dataset.exportIndex, 10),
            tableIndex: input.dataset.colidx !== undefined ? parseInt(input.dataset.colidx, 10) : -1,
            label: input.dataset.label || ''
        }))
        .sort((a, b) => a.exportIndex - b.exportIndex);
}

function _escapeHtml(value) {
    return _cleanText(value)
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;')
        .replace(/'/g, '&#39;');
}

function _mediumBorder(argb) {
    return {
        top: { style: 'medium', color: { argb } },
        bottom: { style: 'medium', color: { argb } },
        left: { style: 'medium', color: { argb } },
        right: { style: 'medium', color: { argb } }
    };
}

function _thinBorder(argb) {
    return {
        top: { style: 'thin', color: { argb } },
        bottom: { style: 'thin', color: { argb } },
        left: { style: 'thin', color: { argb } },
        right: { style: 'thin', color: { argb } }
    };
}

const _safeName = () => (_ctx.filename || 'export').replace(/[^a-zA-Z0-9_-]/g, '_');

function _excelColumnName(index) {
    let name = '';
    let current = index;

    while (current > 0) {
        const remainder = (current - 1) % 26;
        name = String.fromCharCode(65 + remainder) + name;
        current = Math.floor((current - 1) / 26);
    }

    return name || 'A';
}

const _date = () => {
    const now = new Date();
    return now.getFullYear()
        + String(now.getMonth() + 1).padStart(2, '0')
        + String(now.getDate()).padStart(2, '0');
};

function _download(blob, name) {
    const url = URL.createObjectURL(blob);
    const link = document.createElement('a');
    link.href = url;
    link.download = name;
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
    URL.revokeObjectURL(url);
}
