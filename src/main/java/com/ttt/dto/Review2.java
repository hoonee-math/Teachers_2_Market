package com.ttt.dto;

import java.sql.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Review2 {
	private int reviewNo;
	private String reviewContent;
	private List<Image2> reviewImg;
	private double reviewRating;
	private Post2 post;
	private Date reviewDate;
	private int reviewLikeCount;
	private Member2 member;
}
