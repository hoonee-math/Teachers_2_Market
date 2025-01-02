package com.ttt.dto;

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
}
