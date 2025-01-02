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
public class File2 {
	private int fileNo;
	private Post2 post;
	private int isFree;
	private int filePrice;
	private Date salePeriod;
	private String oriname;
	private String renamed;
}
