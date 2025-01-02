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
public class QnA2 {
	private int qnaNo;
	private String qnaTitle;
	private String qnaContent;
	private String answerContent;
	private Date answerDate;
	private Post2 post;
	private Date qndDate;
	private Member2 member;
}
