package com.sukur.educationwebapp.course.entity;

import java.math.BigDecimal;

public class Course {

    private int id;
    private String courseTitle;
    private String courseDescription;
    private String courseAbout;
    private String courseImage;
    private String courseIcon;
    private String cardColorFrom;
    private String cardColorTo;
    private String courseLevel;
    private BigDecimal coursePrice;
    private BigDecimal courseDiscountPrice;
    private int courseDiscountPercent;
    private String courseLanguage;
    private String status;
    private Boolean deleted;

    public Course() {

    }

    public int getId() {
        return id;
    }

    public Course setId(int id) {
        this.id = id;
        return this;
    }

    public String getCourseTitle() {
        return courseTitle;
    }

    public Course setCourseTitle(String courseTitle) {
        this.courseTitle = courseTitle;
        return this;
    }

    public String getCourseDescription() {
        return courseDescription;
    }

    public Course setCourseDescription(String courseDescription) {
        this.courseDescription = courseDescription;
        return this;
    }

    public String getCourseAbout() {
        return courseAbout;
    }

    public Course setCourseAbout(String courseAbout) {
        this.courseAbout = courseAbout;
        return this;
    }

    public String getCourseImage() {
        return courseImage;
    }

    public Course setCourseImage(String courseImage) {
        this.courseImage = courseImage;
        return this;
    }

    public String getCourseIcon() {
        return courseIcon;
    }

    public Course setCourseIcon(String courseIcon) {
        this.courseIcon = courseIcon;
        return this;
    }

    public String getCardColorFrom() {
        return cardColorFrom;
    }

    public Course setCardColorFrom(String cardColorFrom) {
        this.cardColorFrom = cardColorFrom;
        return this;
    }

    public String getCardColorTo() {
        return cardColorTo;
    }

    public Course setCardColorTo(String cardColorTo) {
        this.cardColorTo = cardColorTo;
        return this;
    }

    public String getCourseLevel() {
        return courseLevel;
    }

    public Course setCourseLevel(String courseLevel) {
        this.courseLevel = courseLevel;
        return this;
    }

    public BigDecimal getCoursePrice() {
        return coursePrice;
    }

    public Course setCoursePrice(BigDecimal coursePrice) {
        this.coursePrice = coursePrice;
        return this;
    }

    public BigDecimal getCourseDiscountPrice() {
        return courseDiscountPrice;
    }

    public Course setCourseDiscountPrice(BigDecimal courseDiscountPrice) {
        this.courseDiscountPrice = courseDiscountPrice;
        return this;
    }

    public int getCourseDiscountPercent() {
        return courseDiscountPercent;
    }

    public Course setCourseDiscountPercent(int courseDiscountPercent) {
        this.courseDiscountPercent = courseDiscountPercent;
        return this;
    }

    public String getCourseLanguage() {
        return courseLanguage;
    }

    public Course setCourseLanguage(String courseLanguage) {
        this.courseLanguage = courseLanguage;
        return this;
    }

    public String getStatus() {
        return status;
    }

    public Course setStatus(String status) {
        this.status = status;
        return this;
    }

    public Boolean getDeleted() {
        return deleted;
    }

    public Course setDeleted(Boolean deleted) {
        this.deleted = deleted;
        return this;
    }

    @Override
    public String toString() {
        return id + ". " + courseTitle + " " + courseDescription + " " + coursePrice + " " + courseDiscountPercent + " " + courseDiscountPrice + " " + courseLanguage ;
    }
}
