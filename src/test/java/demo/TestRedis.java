package demo;

import org.junit.Test;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

/**
 * @author:Administrator
 * @create 2018-12-14 16:58
 */
public class TestRedis {
    private static int MAX_WAIT = 10000;



    private static int TIMEOUT = 10000;



    //在borrow一个jedis实例时，是否提前进行validate操作；如果为true，则得到的jedis实例均是可用的；

    private static boolean TEST_ON_BORROW = true;



    private static JedisPool jedisPool = null;

    @Test
    public void testRedis(){
        // 创建连接池
        JedisPoolConfig config = new JedisPoolConfig();
        config.setTestOnBorrow(TEST_ON_BORROW);
        jedisPool = new JedisPool(config, "211.149.210.215", 6379, TIMEOUT, "hnyskj@xzh2018");
        Jedis jedis = jedisPool.getResource();
        jedis.set("username", "helloworld");
        // 根据key取出对应的value值
        String value = jedis.get("username");
        System.out.println(value);
    }
}
