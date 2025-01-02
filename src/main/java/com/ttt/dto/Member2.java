package com.ttt.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Member2 {
	private int memberNo;
	private String memberName;
	private String memberId;
	private String memberPw;
	private String email;
	private String phone;
	private String address;
	private int birthday;
	private int eduType;
	private int subjectNo;
}
