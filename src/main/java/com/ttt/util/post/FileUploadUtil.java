package com.ttt.util.post;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import com.oreilly.servlet.MultipartRequest;
import com.ttt.dto.File2;
import com.ttt.dto.Image2;

public class FileUploadUtil {
    // 파일 저장 기본 디렉토리
    private static final String BASE_UPLOAD_DIR = "resources/upload";
    
    // 파일 종류별 서브 디렉토리
    private static final String FILE_DIR = "files";
    private static final String IMAGE_DIR = "images";
    private static final String TEMP_DIR = "temp";
    
    // 파일 크기 제한 (단위: byte)
    private static final long MAX_FILE_SIZE = 100 * 1024 * 1024;    // 100MB
    private static final long MAX_IMAGE_SIZE = 5 * 1024 * 1024;     // 5MB
    
    // 허용된 파일 확장자
    private static final List<String> ALLOWED_FILE_EXTENSIONS = 
        Arrays.asList("pdf", "doc", "docx", "ppt", "pptx", "xls", "xlsx", "zip");
    private static final List<String> ALLOWED_IMAGE_EXTENSIONS = 
        Arrays.asList("jpg", "jpeg", "png", "gif");

    /**
     * 전체 업로드 경로 가져오기
     */
    public static String getUploadDirectory(String webAppPath, String subDir) {
        return Paths.get(webAppPath, BASE_UPLOAD_DIR, subDir).toString();
    }

    /**
     * 새로운 파일명 생성
     */
    public static String generateFileName(String memberId, int postNo, int sequence, String extension) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        String dateStr = sdf.format(new Date());
        return String.format("%s_%d_%s_%d.%s", memberId, postNo, dateStr, sequence, extension);
    }

    /**
     * 파일 확장자 추출
     */
    public static String getFileExtension(String fileName) {
        if (fileName == null || fileName.lastIndexOf(".") == -1) {
            return "";
        }
        return fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
    }

    /**
     * 파일 유효성 검사
     */
    public static void validateFile(String fileName, long fileSize, boolean isImage) throws IllegalArgumentException {
        String extension = getFileExtension(fileName);
        
        // 파일 확장자 검사
        boolean isValidExtension = isImage ? 
            ALLOWED_IMAGE_EXTENSIONS.contains(extension) : 
            ALLOWED_FILE_EXTENSIONS.contains(extension);
            
        if (!isValidExtension) {
            throw new IllegalArgumentException("허용되지 않은 파일 형식입니다.");
        }
        
        // 파일 크기 검사
        long maxSize = isImage ? MAX_IMAGE_SIZE : MAX_FILE_SIZE;
        if (fileSize > maxSize) {
            throw new IllegalArgumentException(
                String.format("파일 크기는 %dMB를 초과할 수 없습니다.", maxSize / (1024 * 1024))
            );
        }
    }

    /**
     * 판매용 파일 저장
     */
    public static File2 saveFile(MultipartRequest mr, String webAppPath, String memberId, int postNo) throws IOException {
        String uploadDir = getUploadDirectory(webAppPath, FILE_DIR);
        ensureDirectory(uploadDir);

        String originalFileName = mr.getOriginalFileName("uploadFile0");
        if (originalFileName == null) return null;

        String extension = getFileExtension(originalFileName);
        validateFile(originalFileName, mr.getFile("uploadFile0").length(), false);
        
        String renamedFileName = generateFileName(memberId, postNo, 1, extension);
        
        // 파일 저장
        File originalFile = mr.getFile("uploadFile0");
        File renamedFile = new File(uploadDir, renamedFileName);
        
        if (!originalFile.renameTo(renamedFile)) {
            Files.copy(originalFile.toPath(), renamedFile.toPath());
            originalFile.delete();
        }

        return File2.builder()
                .oriname(originalFileName)
                .renamed(renamedFileName)
                .build();
    }

    /**
     * 상품 이미지 저장
     */
    public static List<Image2> saveImages(MultipartRequest mr, String webAppPath, String memberId, int postNo) throws IOException {
        List<Image2> images = new ArrayList<>();
        String uploadDir = getUploadDirectory(webAppPath, IMAGE_DIR);
        ensureDirectory(uploadDir);
        
        // 파일 입력 필드명 가져오기 (upfile0, upfile1, ...)
        int sequence = 1;
        for (String fileParam : getFileParameters(mr)) {
            String originalFileName = mr.getOriginalFileName(fileParam);
            if (originalFileName == null) continue;
            
            String extension = getFileExtension(originalFileName);
            validateFile(originalFileName, mr.getFile(fileParam).length(), true);
            
            String renamedFileName = generateFileName(memberId, postNo, sequence++, extension);
            
            // 파일 저장
            File originalFile = mr.getFile(fileParam);
            File renamedFile = new File(uploadDir, renamedFileName);
            
            if (!originalFile.renameTo(renamedFile)) {
                Files.copy(originalFile.toPath(), renamedFile.toPath());
                originalFile.delete();
            }
            
            images.add(Image2.builder()
                    .oriname(originalFileName)
                    .renamed(renamedFileName)
                    .imgSeq(sequence - 1)
                    .build());
        }
        
        return images;
    }

    /**
     * 디렉토리 존재 확인 및 생성
     */
    private static void ensureDirectory(String directory) throws IOException {
        Path path = Paths.get(directory);
        if (!Files.exists(path)) {
            Files.createDirectories(path);
        }
    }

    /**
     * MultipartRequest에서 파일 파라미터명 추출
     */
    private static List<String> getFileParameters(MultipartRequest mr) {
        List<String> fileParams = new ArrayList<>();
        java.util.Enumeration<?> files = mr.getFileNames();
        while (files.hasMoreElements()) {
            String name = (String) files.nextElement();
            if (name.startsWith("upfile")) {
                fileParams.add(name);
            }
        }
        return fileParams;
    }

}
