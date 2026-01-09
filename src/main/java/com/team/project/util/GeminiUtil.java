package com.team.project.util;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;

public class GeminiUtil {

    // Secret 클래스에서 키를 가져옴
    private static final String API_KEY = Secret.GEMINI_KEY;
    
    // gemini-2.5-flash 모델 사용
    private static final String API_URL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=" + API_KEY;

    public static String getGeminiResponse(String prompt) {
        String aiAnswer = "";
        
        try {
            URL url = new URL(API_URL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setDoOutput(true);

            // JSON 깨짐 방지 (역슬래시를 가장 먼저 처리해야 함)
            String safePrompt = prompt.replace("\\", "\\\\")  // 1. 역슬래시 이스케이프
                                      .replace("\"", "\\\"")  // 2. 따옴표 이스케이프
                                      .replace("\r", "")      // 3. 캐리지 리턴 제거
                                      .replace("\n", "\\n");  // 4. 줄바꿈 문자 처리

            String jsonInputString = "{ \"contents\": [{ \"parts\": [{ \"text\": \"" + safePrompt + "\" }] }] }";

            try (OutputStream os = conn.getOutputStream()) {
                byte[] input = jsonInputString.getBytes(StandardCharsets.UTF_8);
                os.write(input, 0, input.length);
            }

            int responseCode = conn.getResponseCode();
            InputStream stream;
            
            if (responseCode == 200) {
                stream = conn.getInputStream(); 
            } else {
                stream = conn.getErrorStream(); 
            }

            try (BufferedReader br = new BufferedReader(new InputStreamReader(stream, StandardCharsets.UTF_8))) {
                StringBuilder response = new StringBuilder();
                String responseLine;
                while ((responseLine = br.readLine()) != null) {
                    response.append(responseLine.trim());
                }
                
                if (responseCode == 200) {
                    String raw = response.toString();
                    // "text": "..." 추출 로직
                    int textIndex = raw.indexOf("\"text\": \"");
                    if (textIndex != -1) {
                        int startIndex = textIndex + 9;
                        int endIndex = raw.indexOf("\"", startIndex);
                        
                        // 인덱스 범위 체크
                        if (endIndex > startIndex) {
                            aiAnswer = raw.substring(startIndex, endIndex).replace("\\n", "\n").replace("\\\"", "\"");
                        } else {
                            aiAnswer = raw; // 파싱 실패 시 원본 반환
                        }
                    } else {
                        aiAnswer = raw; 
                    }
                } else {
                    System.out.println("API 에러 로그: " + response.toString());
                    aiAnswer = "죄송합니다. AI 서버 연결 중 오류가 발생했습니다. (데이터 형식 문제)";
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            aiAnswer = "시스템 에러가 발생했습니다.";
        }

        return aiAnswer;
    }
}