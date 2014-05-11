package com.rent1.shop;

import java.util.Vector;

import lombok.Getter;
import lombok.Setter;

public class ShoppingCart {
	@Getter @Setter protected Vector<ShoppingCartItem> items;
	@Getter @Setter protected int total;

	public ShoppingCart() {
		items = new Vector<ShoppingCartItem>();
		total = 0;
	}

	public void addItem(ShoppingCartItem newItem) {
		items.addElement(newItem);
		total++;
	}
	
	public void removeItem(ShoppingCartItem oldItem){
		int currIndex = items.indexOf(oldItem);
		if(currIndex == -1){
			return;
		}else{
			items.removeElementAt(currIndex);
			total--;
		}
	}
}
