package com.talini.pov_bac.config;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Component;

import java.io.IOException;

@Component
public class ContentTypeFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, jakarta.servlet.ServletException {

        if (request instanceof HttpServletRequest httpRequest) {
            String contentType = httpRequest.getContentType();
            if (contentType != null && contentType.contains("application/json;charset=utf-8")) {
                request.setAttribute("Content-Type", "application/json");
            }
        }
        chain.doFilter(request, response);
    }
}

