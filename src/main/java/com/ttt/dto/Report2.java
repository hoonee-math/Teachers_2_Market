package com.ttt.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Report2 {
	private int reportNo;
	private Member2 author;
	private Member2 reported;
	private Post2 post;
	private Date reportDate;
	private String reportContent;
	private int isChecked;
	private int reporttypeNo;
}
