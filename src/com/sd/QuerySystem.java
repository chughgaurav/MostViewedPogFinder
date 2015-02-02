package com.sd;

import com.aerospike.client.AerospikeClient;
import com.aerospike.client.Key;
import com.aerospike.client.Record;
import com.aerospike.client.Value;
import com.aerospike.client.policy.WritePolicy;

public class QuerySystem {

	public static void main(String[] args){
		QuerySystem obj = new QuerySystem();
		obj.findTrendingPog();
	}
	
	private void findTrendingPog(){
		//takes average of hits from T1 to T5,then sorts & then returns pog with highest hit count
		
		AerospikeClient client = new AerospikeClient("127.0.0.1", 3000);
		
		try{
        	// Initialize policy.
        	WritePolicy writePolicy = new WritePolicy();
        	writePolicy.timeout = 500;  // 50 millisecond timeout.

        	Key key = new Key("test", "demo2", "pogIdList");
        	
        	String result = String.valueOf(
        			client.execute(writePolicy, key, "querySystem", "querySystem")
        			);
        	
        	System.out.println("result: " + result);
        	
        }
        catch(Exception e){
        	e.printStackTrace();
        }
        finally {
            client.close();
            System.out.println("exiting.....");
        }
	}
}
