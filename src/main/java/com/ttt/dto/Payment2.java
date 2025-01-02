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
public class Payment2 {
	private int paymentNo;
	private int totalPrice;
	private Date paymentDate;
	private Member2 seller;
	private Member2 buyer;
	private Post2 post;
}
