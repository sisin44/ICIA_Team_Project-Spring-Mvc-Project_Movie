package icia.kotlin.mapper;

import java.util.ArrayList;

import icia.kotlin.beans.ServiceBeans;

public interface MapperInterface {
	
	public int isMember(ServiceBeans sb);
	public int isAccess(ServiceBeans sb);
	public ServiceBeans getMemberInfo(ServiceBeans sb);
	public int insCustomer(ServiceBeans sb);
	public int insMovie(ServiceBeans sb);
	
}
