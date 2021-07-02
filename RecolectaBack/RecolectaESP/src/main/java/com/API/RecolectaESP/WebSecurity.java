package com.API.RecolectaESP;


import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;

public class WebSecurity {

    protected void configuracionSwagger (HttpSecurity httpSeguridad) throws  Exception{
        httpSeguridad.cors().and().csrf().disable().sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                .and().authorizeRequests().antMatchers("/**").permitAll().antMatchers("/**");
    }
}
