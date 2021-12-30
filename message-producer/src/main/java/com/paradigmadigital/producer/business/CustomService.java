package com.paradigmadigital.producer.business;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;

@Service
public class CustomService {
  
  @Value("${kafka.topic}")
  private String topic;
  
  private KafkaTemplate<String, String> kafkaTemplate;
  
  public CustomService(KafkaTemplate kafkaTemplate){
    this.kafkaTemplate = kafkaTemplate;
  }
  
  public void sendMessage(String key, String msg) {
    kafkaTemplate.send(topic, key, msg);
  }
  
}
