package com.ttt.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Warning2 {
	private int warningNo;
	private Member2 member;
	private Report2 report;
	private int isSend;
	private Date sendDate;
}
