package springboot.controller;

import io.micrometer.core.instrument.Counter;
import io.micrometer.core.instrument.MeterRegistry;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import javax.annotation.PostConstruct;

@RestController
public class HelloWorldController {

    @Autowired
    MeterRegistry registry;

    // Prometheus Count 数据类型
    private Counter requests;

    @PostConstruct
    private void init(){
        // 定义 指标名 和 标签
        requests = registry.counter("requests_total", "method", "sayHello");
    }

    @RequestMapping("/")
    public String sayHello() {
        // # 开始统计访问次数
        try{
            requests.increment();
        } catch (Exception e) {
            return e.toString();
        }
        return "Hello,SkyWalking! visit " + requests.count();
    }
}
