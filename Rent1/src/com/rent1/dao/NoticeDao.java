package com.rent1.dao;

import static com.rent1.service.OfyService.ofy;

import java.util.List;

import com.rent1.entity.Notice;
import com.rent1.entity.User;

public enum NoticeDao {
	INSTANCE;

	public Notice addNotice(Notice note) {
		ofy().save().entity(note).now();
		return note;
	}

	public List<Notice> getNoticesByUser(User user) {
		List<Notice> notices = ofy().load().type(Notice.class).ancestor(user)
				.list();

		return notices;
	}

	public void deleteNotice(Notice note) {
		User user = note.getUser();
		ofy().delete().entity(note).now();
		user.getNotices(true);
	}
}
