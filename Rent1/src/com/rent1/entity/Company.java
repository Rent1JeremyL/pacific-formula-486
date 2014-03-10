package com.rent1.entity;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import com.googlecode.objectify.annotation.Cache;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;

@Entity@Cache
@NoArgsConstructor
public class Company {
	@Id
	@Getter
	@Setter
	private Long id;
}
