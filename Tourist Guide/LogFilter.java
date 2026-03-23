package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebFilter("/*")
public class LogFilter implements Filter {

    private static final DateTimeFormatter FMT =
            DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    @Override
    public void init(FilterConfig filterConfig) {
        System.out.println("[TouristGuide] LogFilter initialized.");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpReq = (HttpServletRequest) request;
        String time   = LocalDateTime.now().format(FMT);
        String method = httpReq.getMethod();
        String uri    = httpReq.getRequestURI();
        String query  = httpReq.getQueryString();

        System.out.printf("[%s] %s %s%s%n", time, method, uri,
                          (query != null ? "?" + query : ""));

        // Pass request along the chain
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        System.out.println("[TouristGuide] LogFilter destroyed.");
    }
}
