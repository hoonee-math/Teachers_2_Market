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
public class Post2 {
	private int postNo;
	private Date postDate;
	private String postTitle;
	private String postContent;
	private List<Image2> postImg;
	private int categoryNo;
	private int subjectNo;
	private int viewCount;
	private int isTemp;
	private Member2 member;
	private int isDeleted;
	private int productType;
	private int isFix;
}
