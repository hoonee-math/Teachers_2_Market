package com.ttt.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Product2 {
	private int productNo;
	private Post2 post;
	private int isFree;
	private int productPrice;
	private int hasDeliveryFee;
	private int deliveryFee;
	private int stockCount;
}
