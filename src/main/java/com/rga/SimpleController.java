package com.rga;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class SimpleController {

  @GetMapping("/hello")
  public Message simple() {
    return new Message("Hello World!");
  }

}
