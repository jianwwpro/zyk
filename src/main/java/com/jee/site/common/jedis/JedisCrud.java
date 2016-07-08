package com.jee.site.common.jedis;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import java.util.UUID;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.Tuple;

import com.google.common.collect.Maps;
import com.jee.site.common.persistence.BaseEntity;
import com.jee.site.common.utils.ObjectUtils;
import com.jee.site.common.utils.StringUtils;

/**
 * redis缓存数据
 * 
 * @author jsb
 *
 */
public class JedisCrud {

	private static String[] keys;

	/**
	 * 插入hash对象
	 * 
	 * @param o
	 */
	public static void insert(BaseEntity... os) {
		Jedis resource = JedisUtils.getResource();
		try {
			for (BaseEntity o : os) {
				if (o == null || StringUtils.isBlank(o.getId())) {
					return;
				}
				Class<? extends BaseEntity> clz = o.getClass();
				String simpleName = clz.getSimpleName();
				String id = o.getId();
				for (clz = o.getClass(); clz != BaseEntity.class.getSuperclass(); clz = (Class<? extends BaseEntity>) clz.getSuperclass()) {
					Field[] declaredFields = clz.getDeclaredFields();
					for (Field field : declaredFields) {
						field.setAccessible(true);
						String fieldName = field.getName();
						Object fieldValue = field.get(o);
						if (fieldValue != null)
							resource.hset((simpleName + "-" + id).getBytes(), fieldName.getBytes(), ObjectUtils.serialize(fieldValue));
					}
				}

			}
		} catch (Exception e) {
			throw new RuntimeException("REDIS操作插入数据失败：" + e.getMessage());
		} finally {
			JedisUtils.returnResource(resource);
		}
	}

	public static void remove(BaseEntity... os) {
		Jedis resource = JedisUtils.getResource();
		try {
			for (BaseEntity o : os) {
				if (o == null || StringUtils.isBlank(o.getId())) {
					return;
				}
				Class<? extends BaseEntity> clz = o.getClass();
				String simpleName = clz.getSimpleName();
				String id = o.getId();
				resource.del((simpleName + "-" + id).getBytes());

			}
		} catch (Exception e) {
			throw new RuntimeException("REDIS操作插入数据失败：" + e.getMessage());
		} finally {
			JedisUtils.returnResource(resource);
		}
	}

	/**
	 * 插入有序集合
	 * 
	 * @param o
	 */
	public static void insertZset(String key, Map<String, Double> scoreMembers) {
		Jedis resource = JedisUtils.getResource();
		try {
			resource.zadd(key, scoreMembers);
		} catch (Exception e) {
			throw new RuntimeException("REDIS操作插入数据失败：" + e.getMessage());
		} finally {
			JedisUtils.returnResource(resource);
		}
	}

	/**
	 * 插入有序集合
	 * 
	 * @param o
	 */
	public static void insertZset(byte[] key, Map<byte[], Double> scoreMembers) {
		Jedis resource = JedisUtils.getResource();
		try {
			resource.zadd(key, scoreMembers);
		} catch (Exception e) {
			throw new RuntimeException("REDIS操作插入数据失败：" + e.getMessage());
		} finally {
			JedisUtils.returnResource(resource);
		}
	}

	/**
	 * 删除有序集
	 * 
	 * @param journalLsit
	 * @param journals
	 */
	public static void removeZet(String key, String... members) {
		Jedis resource = JedisUtils.getResource();
		try {
			resource.zrem(key, members);
		} catch (Exception e) {
			throw new RuntimeException("REDIS操作插入数据失败：" + e.getMessage());
		} finally {
			JedisUtils.returnResource(resource);
		}
	}
	/**
	 * 删除集
	 * 
	 * @param journalLsit
	 * @param journals
	 */
	public static void removeSet(String key, String... members) {
		Jedis resource = JedisUtils.getResource();
		try {
			resource.srem(key, members);
		} catch (Exception e) {
			throw new RuntimeException("REDIS操作插入数据失败：" + e.getMessage());
		} finally {
			JedisUtils.returnResource(resource);
		}
	}
	

	/**
	 * 删除key
	 * 
	 * @param journalLsit
	 * @param journals
	 */
	public static void del(String key) {
		Jedis resource = JedisUtils.getResource();
		try {
			resource.del(key);
		} catch (Exception e) {
			throw new RuntimeException("REDIS操作插入数据失败：" + e.getMessage());
		} finally {
			JedisUtils.returnResource(resource);
		}
	}
	/**
	 * s搜索key
	 * 
	 * @param journalLsit
	 * @param journals
	 * @return 
	 */
	public static Set<String> keys(String key) {
		Jedis resource = JedisUtils.getResource();
		try {
			return resource.keys(key);
		} catch (Exception e) {
			throw new RuntimeException("REDIS操作插入数据失败：" + e.getMessage());
		} finally {
			JedisUtils.returnResource(resource);
		}
	}
	
	/**
	 * 搜索key
	 * 
	 * @param journalLsit
	 * @param journals
	 * @return 
	 */
	public static Set<byte[]> keys(byte[] key) {
		Jedis resource = JedisUtils.getResource();
		try {
			return resource.keys(key);
		} catch (Exception e) {
			throw new RuntimeException("REDIS操作插入数据失败：" + e.getMessage());
		} finally {
			JedisUtils.returnResource(resource);
		}
	}


	/**
	 * 删除key
	 * 
	 * @param journalLsit
	 * @param journals
	 */
	public static void del(byte[] key) {
		Jedis resource = JedisUtils.getResource();
		try {
			resource.del(key);
		} catch (Exception e) {
			throw new RuntimeException("REDIS操作插入数据失败：" + e.getMessage());
		} finally {
			JedisUtils.returnResource(resource);
		}
	}

	/**
	 * 获取数据
	 * 
	 * @param o
	 * @return
	 */
	public static BaseEntity get(BaseEntity o) {
		Jedis resource = JedisUtils.getResource();
		try {
			Class<? extends BaseEntity> clz = o.getClass();
			String simpleName = clz.getSimpleName();
			String id = o.getId();
			Map<byte[], byte[]> map = resource.hgetAll((simpleName + "-" + id).getBytes());

			Set<Entry<byte[], byte[]>> entrySet = map.entrySet();

			BaseEntity result = clz.newInstance();
			for (Entry<byte[], byte[]> entry : entrySet) {
				byte[] key = entry.getKey();
				byte[] value = entry.getValue();
				Object keyObj = new String(key);
				Object valueObj = ObjectUtils.unserialize(value);
				org.apache.commons.beanutils.BeanUtils.setProperty(result, keyObj.toString(), valueObj);
			}
			return result;
		} catch (Exception e) {
			throw new RuntimeException("REDIS获取数据失败：" + e.getMessage());
		} finally {
			JedisUtils.returnResource(resource);
		}
	}

	/**
	 * 获取数据
	 * 
	 * @param o
	 * @return
	 */
	public static List rangeZset(byte[] key, int start, int end) {
		Jedis resource = JedisUtils.getResource();
		try {
			Set<byte[]> zrange = resource.zrange(key, start, end-1);
			List<Object> object = new ArrayList<Object>();
			for (byte[] bs : zrange) {
				Object unserialize = ObjectUtils.unserialize(bs);
				object.add(unserialize);
			}
			return object;
		} catch (Exception e) {
			throw new RuntimeException("REDIS获取数据失败：" + e.getMessage());
		} finally {
			JedisUtils.returnResource(resource);
		}
	}

	
	/**
	 * 获取数据
	 * 
	 * @param o
	 * @return
	 */
	public static List smembers(String key) {
		Jedis resource = JedisUtils.getResource();
		try {
			
			Set<String> smembers = resource.smembers(key);
			List<String> object = new ArrayList<String>();
			for (String s : smembers) {
				
				object.add(s);
			}
			return object;
		} catch (Exception e) {
			throw new RuntimeException("REDIS获取数据失败：" + e.getMessage());
		} finally {
			JedisUtils.returnResource(resource);
		}
	}
	public static List<String> rangeZsetByScore(String key, int start, int count,Double min, Double max) {
		Jedis resource = JedisUtils.getResource();
		try {
			
			Set<String> zrange = resource.zrangeByScore(key, min, max, start, count);
			List<String> object = new ArrayList<String>();
			for (String bs : zrange) {

				object.add(bs);
			}
			return object;
		} catch (Exception e) {
			throw new RuntimeException("REDIS获取数据失败：" + e.getMessage());
		} finally {
			JedisUtils.returnResource(resource);
		}
	}
	
	public static Long zcount(String key,Double min, Double max) {
		Jedis resource = JedisUtils.getResource();
		try {
			
			Long zcount = resource.zcount(key, min, max);
			
			return zcount;
		} catch (Exception e) {
			throw new RuntimeException("REDIS获取数据失败：" + e.getMessage());
		} finally {
			JedisUtils.returnResource(resource);
		}
	}
	
	/**
	 * 查看zset集合的成员个数
	 * @param key
	 * @return
	 */
	public static Long zcard(String key) {
		Jedis resource = JedisUtils.getResource();
		try {
			Long zcount = resource.zcard(key);
			return zcount;
		} catch (Exception e) {
			throw new RuntimeException("REDIS获取数据失败：" + e.getMessage());
		} finally {
			JedisUtils.returnResource(resource);
		}
	}
	
	
	public static List<String> rangeZset(String key, int start, int end,boolean isAsc) {
		Jedis resource = JedisUtils.getResource();
		try {
			Set<String> zrange=null;
			if(isAsc){
			 zrange= resource.zrange(key, start, end-1);
			}else {
				zrange = resource.zrevrange(key, start, end-1);
				
			}
			
			List<String> object = new ArrayList<String>();
			for (String bs : zrange) {

				object.add(bs);
			}
			return object;
		} catch (Exception e) {
			throw new RuntimeException("REDIS获取数据失败：" + e.getMessage());
		} finally {
			JedisUtils.returnResource(resource);
		}

	}
	
	public static Map<String,Double> rangeZsetWithScore(String key, int start, int end,boolean isAsc) {
		Jedis resource = JedisUtils.getResource();
		try {
			Set<Tuple> zrangeWithScores =null;
			if(isAsc){
				zrangeWithScores= resource.zrangeWithScores(key, start, end-1);
			}else {
				zrangeWithScores = resource.zrangeWithScores(key, start, end-1);
				
			}
			
			Map<String,Double> object =Maps.newHashMap();
			for (Tuple bs : zrangeWithScores) {
				byte[] binaryElement = bs.getBinaryElement();
				 String str = new String(binaryElement,"UTF-8");
				 object.put(str, bs.getScore());
			}
			return object;
		} catch (Exception e) {
			throw new RuntimeException("REDIS获取数据失败：" + e.getMessage());
		} finally {
			JedisUtils.returnResource(resource);
		}
		
	}
/**
 * 交集
 * @param start
 * @param end
 * @param keys
 * @return
 */
	public static List<String> zinter(int start, int end, String... keys) {

		Jedis resource = JedisUtils.getResource();
		try {
			String uuid = UUID.randomUUID().toString();
			resource.zinterstore(uuid, keys);
			List<String> result = JedisCrud.rangeZset(uuid, start, end-1,true);
			resource.del(uuid);
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JedisUtils.returnResource(resource);
		}
		return null;

	}
	
	/**
	 * 交集
	 * @param start
	 * @param end
	 * @param keys
	 * @return
	 */
		public static List<String> zunion(int start, int end, String... keys) {

			Jedis resource = JedisUtils.getResource();
			try {
				String uuid = UUID.randomUUID().toString();
				resource.zunionstore(uuid, keys);
				List<String> result = JedisCrud.rangeZset(uuid, start, end-1,true);
				resource.del(uuid);
				return result;
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				JedisUtils.returnResource(resource);
			}
			return null;

		}

	
	
	/**
	 * 插入集合
	 * 
	 * @param o
	 */
	public static void insertSet(String key, String ... value) {
		Jedis resource = JedisUtils.getResource();
		try {
			resource.sadd(key, value);
		} catch (Exception e) {
			throw new RuntimeException("REDIS操作插入数据失败：" + e.getMessage());
		} finally {
			JedisUtils.returnResource(resource);
		}
	}
	
	/**
	 * 插入集合
	 * 
	 * @param o
	 */
	public static boolean ismemberSet(String key, String value) {
		Jedis resource = JedisUtils.getResource();
		try {
			return resource.sismember(key, value);
		} catch (Exception e) {
			throw new RuntimeException("REDIS操作插入数据失败：" + e.getMessage());
		} finally {
			JedisUtils.returnResource(resource);
		}
	}
	
	/**
	 * 插入集合
	 * 
	 * @param o
	 */
	public static boolean ismemberZSet(String key, String value) {
		Jedis resource = JedisUtils.getResource();
		try {
			Long zrank = resource.zrank(key, value);
			return zrank==null?false:true;
		} catch (Exception e) {
			throw new RuntimeException("REDIS操作插入数据失败：" + e.getMessage());
		} finally {
			JedisUtils.returnResource(resource);
		}
	}
	
	
	/**
	 * 插入hashmap
	 * 
	 * @param o
	 */
	public static void hset(String key,String field, String value) {
		Jedis resource = JedisUtils.getResource();
		try {
			resource.hset(key, field, value);
		} catch (Exception e) {
			throw new RuntimeException("REDIS操作插入数据失败：" + e.getMessage());
		} finally {
			JedisUtils.returnResource(resource);
		}
	}
	/**
	 * hashmap取值
	 * 
	 * @param o
	 */
	public static String hget(String key,String field) {
		Jedis resource = JedisUtils.getResource();
		try {
			return resource. hget(key, field);
		} catch (Exception e) {
			throw new RuntimeException("REDIS操作插入数据失败：" + e.getMessage());
		} finally {
			JedisUtils.returnResource(resource);
		}
	}
	
	/**
	 * 是否存在
	 * 
	 * @param o
	 */
	public static boolean hexists(String key,String field) {
		Jedis resource = JedisUtils.getResource();
		try {
			return resource.hexists(key, field);
		} catch (Exception e) {
			throw new RuntimeException("REDIS操作插入数据失败：" + e.getMessage());
		} finally {
			JedisUtils.returnResource(resource);
		}
	}
	
	/**
	 * 获取value
	 * 
	 * @param o
	 */
	public static List<String> hvalues(String key) {
		Jedis resource = JedisUtils.getResource();
		try {
			return resource.hvals(key);
		} catch (Exception e) {
			throw new RuntimeException("REDIS操作插入数据失败：" + e.getMessage());
		} finally {
			JedisUtils.returnResource(resource);
		}
	}
	
}
