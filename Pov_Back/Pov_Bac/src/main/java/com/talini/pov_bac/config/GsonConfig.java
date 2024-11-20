package com.talini.pov_bac.config;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.json.GsonHttpMessageConverter;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

@Configuration
public class GsonConfig {

    @Bean
    public HttpMessageConverter<?> gsonHttpMessageConverter() {
        Gson gson = new GsonBuilder().create(); // Add Gson library as a dependency in build configuration
        return new GsonHttpMessageConverter(gson);
    }
}
