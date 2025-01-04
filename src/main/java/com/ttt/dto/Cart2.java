package com.ttt.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Cart2 {
	private int cartNo;
	private int isPayment;
	private Post2 post;
	private Payment2 payment;
	private Member2 member;
	private Product2 product2;
	private File2 file2;
	private List<Image2> postImg;
}
