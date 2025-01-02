package com.ttt.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Image2 {
	private int imgNo;
	private int imgSeq;
	private int postNo;
	private Review2 review;
	private String oriname;
	private String renamed;
}
