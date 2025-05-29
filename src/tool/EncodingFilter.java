package tool;

import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public abstract class EncodingFilter{

    public void init(
    		FilterConfig  filterConfig
    		) {
	}

    public abstract void doFilter(
    		ServletRequest req, ServletResponse res, FilterChain chain
    		) throws Exception;



    public abstract void destroy(

    		) throws Exception;




}