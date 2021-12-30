package com.paradigmadigital.producer.schedule;

import com.paradigmadigital.producer.business.CustomService;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.concurrent.atomic.AtomicLong;

@Component
public class ProducerSchedule {
  
  private final CustomService customService;
  private final AtomicLong counter;
  
  public ProducerSchedule(CustomService customService){
    this.customService = customService;
    this.counter = new AtomicLong(1);
  }
  
  @Scheduled(fixedDelay = 20000, initialDelay = 10000)
  public void generateMessage(){
    String key = String.valueOf(counter.getAndIncrement());
    String message = "product" + key;
    customService.sendMessage(key, message);
    System.out.println("event sent!");
  }
  
}
