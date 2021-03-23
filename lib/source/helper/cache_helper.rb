module Helper
	def Helper.find_chapter_by_number(manga_id, chapter_number)
		return $DB[:chapter]
		.where(chapter_n: chapter_number)
		.join(:manga_chapter, chapter_id: :chapter_id)
		.where(manga_id: manga_id).first
	end

	def Helper.find_manga_by_title(source_id, manga_title)
		return $DB[:manga]
		.where(title: manga_title)
		.join(:source_manga, manga_id: :manga_id)
		.where(source_id: source_id).first
	end

	def Helper.find_manga_by_title_or_id(source_id, manga_id)
		return $DB[:manga]
		.where(Sequel.or(manga_id: manga_id, title: manga_id))
		.natural_join(:source_manga).first
	end

	def Helper.store_manga(source_id, manga_info)
		$DB[:manga]
		.on_duplicate_key_update()
		.insert(manga_info)
		$DB[:source_manga]
		.insert({
			manga_id: manga_info[:manga_id],
			source_id: source_id,
		})
	end

	def Helper.store_manga_chapter(manga_id, chapter_info)
		$DB[:chapter]
		.on_duplicate_key_update()
		.insert(chapter_info)
		$DB[:manga_chapter]
		.on_duplicate_key_update()
		.insert({
			chapter_id: chapter_info[:chapter_id],
			manga_id: manga_id,
		})
	end

	def Helper.store_tags(manga_id, tag_list)
		for tag in tag_list
			tag_data = $DB[:tag].where(title: tag).first
			tag_id = tag_data ? tag_data[:tag_id] : 
			if !tag_data
				$DB[:tag].insert(
					tag_id: tag_id,
					title: tag
				)
			end

			tag_data = $DB[:tag]
			.where(tag_id: tag_id).first
	
			manga_tag_info = $DB[:manga]
			.natural_join(:manga_tag)
			.where({manga_id: manga_id, tag_id: tag_id}).first
			if !manga_tag_info
				$DB[:manga_tag]
				.insert(
					manga_id: manga_id,
					tag_id: tag_id
				)
			end
		end
	end
end