---
title: spring-security
copyright: true
mathjax: false
date: 2020-11-07 13:40:33
categories:
tags:
---
文章简介

<!-- more -->

```java
@Configuration
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    private UserService userService;

    @Autowired
    private AuthTokenFilter authTokenFilter;

    @Bean
    public AuthenticationEntryPoint authenticationEntryPoint() {
        return new AuthException();
    }

    @Bean
    public AccessDeniedHandler accessDeniedHandler() {
        return new AuthAccessDeniedHandler();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new SimplePasswordEncoder();
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.csrf().disable()
                .authorizeRequests()
                .antMatchers("/", "/doLogin", "/allSee").permitAll()
                .anyRequest().authenticated()
                .and()
                .formLogin().disable()
                .logout().disable()
                .addFilterAt(authTokenFilter, UsernamePasswordAuthenticationFilter.class)
                // 增加一个异常处理器，当后端校验失败时，默认返回error，现在返回错误码，前端根据错误码跳转到login页面
                .exceptionHandling().accessDeniedHandler(accessDeniedHandler())
                // 增加一个异常抛出，前端不携带token访问需要token的页面时，后端默认返回error，现在后端返回need_login错误码，这样前端可以根据错误码跳转到login页面
                .authenticationEntryPoint(authenticationEntryPoint());
    }

    @Bean
    public DaoAuthenticationProvider daoAuthenticationProvider() {
        DaoAuthenticationProvider daoAuthenticationProvider = new DaoAuthenticationProvider();
        daoAuthenticationProvider.setUserDetailsService(userService);
        daoAuthenticationProvider.setPasswordEncoder(passwordEncoder());
        daoAuthenticationProvider.setHideUserNotFoundExceptions(true);
        return daoAuthenticationProvider;
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.authenticationProvider(daoAuthenticationProvider());
    }
}
```

