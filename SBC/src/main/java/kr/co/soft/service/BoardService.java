package kr.co.soft.service;

import java.io.File;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.co.soft.beans.ContentBean;
import kr.co.soft.beans.UserBean;
import kr.co.soft.dao.BoardDao;

@Service
@PropertySource("/WEB-INF/properties/option.properties")
public class BoardService {

	@Value("${path.upload}")
	private String path_upload;

	@Autowired
	private BoardDao boardDao;

	@Resource(name = "loginUserBean")
	private UserBean loginUserBean;

	private String saveUploadFile(MultipartFile upload_file) {

		// 현재시간과 오리지널 파일 네임
		// String file_name = System.currentTimeMillis() + "_" +
		// upload_file.getOriginalFilename();
		// String file_name = System.currentTimeMillis() + "_" + upload_file.getName();
		String file_name = System.currentTimeMillis() + "_"
				+ FilenameUtils.getBaseName(upload_file.getOriginalFilename()) + "."
				+ FilenameUtils.getExtension(upload_file.getOriginalFilename());

		try {
			upload_file.transferTo(new File(path_upload + "/" + file_name));
		} catch (Exception e) {
			e.printStackTrace();
		}

		return file_name;
	}

	// =================================================================

	public void addContentInfo(ContentBean writeContentBean) {

		MultipartFile upload_file = writeContentBean.getUpload_file();

		if (upload_file.getSize() > 0) {
			String file_name = saveUploadFile(upload_file);
			System.out.println(file_name);

			// 오라클에 저장 될 파일 이름으로 활용하는 코드
			writeContentBean.setContent_file(file_name);
		}

		writeContentBean.setContent_writer_idx(loginUserBean.getUser_idx());

		boardDao.addContentInfo(writeContentBean);

	}

	public String getBoardInfoName(int board_info_idx) {

		return boardDao.getBoardInfoName(board_info_idx);
	}

	public List<ContentBean> getContentList(int board_info_idx) {

		return boardDao.getContentList(board_info_idx);
	}

	public ContentBean getContentInfo(int content_idx) {

		return boardDao.getContentInfo(content_idx);
	}

	public void modifyContentInfo(ContentBean modifyContentBean) {

		MultipartFile upload_file = modifyContentBean.getUpload_file();
		
		if (upload_file.getSize() > 0) { //upload_file에 해당 파일이 있다면
			String file_name = saveUploadFile(upload_file);
			
			modifyContentBean.setContent_file(file_name);
			
		}
		
		boardDao.modifyContentInfo(modifyContentBean);
	}
	
	public void deleteContentInfo(int content_idx) {
		
		boardDao.deleteContentInfo(content_idx);
	}

}
