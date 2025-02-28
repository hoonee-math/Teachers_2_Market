package com.ttt.common.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;

import com.ttt.common.PasswordEncoding;

@WebFilter(servletNames= {
		"memberEnroll", "memberLoginServlet", "resetPassword", "updatePassword"
})
public class PasswordEncryptFilter extends HttpFilter implements Filter {
	
    public PasswordEncryptFilter() {
        super();
    }

	public void destroy() {
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// place your code here
		PasswordEncoding pe=new PasswordEncoding((HttpServletRequest)request);
		// pass the request along the filter chain
		chain.doFilter(pe, response);
	}

	public void init(FilterConfig fConfig) throws ServletException {
	}
}
