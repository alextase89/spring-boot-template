package com.tase.template.controller;

import com.tase.template.configuration.Constant;
import io.swagger.annotations.ApiParam;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(Constant.ROOT_CONTEXT + "/test")
public class TestController {

    @GetMapping
    public ResponseEntity<String> test(
        @ApiParam(value = "test", required = false) @RequestParam(value = "test") String test){
        return ResponseEntity.ok(test);
    }
}
