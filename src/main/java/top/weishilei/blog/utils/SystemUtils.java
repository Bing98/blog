package top.weishilei.blog.utils;

import java.net.InetAddress;
import java.util.HashMap;
import java.util.Map;

/**
 * 获取系统信息工具类
 */
public class SystemUtils {

    public static Map<String, String> getSystemInfo() {
        Map<String, String> info = new HashMap<>();
        String os = System.getProperty("os.name");
        String ip = "127.0.0.1";
        Runtime rt = Runtime.getRuntime();
        int byteToMb = 1024 * 1024;
        long vmTotal = rt.totalMemory() / byteToMb;
        long vmUse = vmTotal - rt.freeMemory() / byteToMb;
        try {
            ip = InetAddress.getLocalHost().getHostAddress();
        } catch (Exception e) {}
        info.put("os", os);
        info.put("ip", ip);
        info.put("javaHome", System.getProperty("java.home"));
        info.put("userDir", System.getProperty("user.dir"));
        info.put("version", System.getProperty("java.version"));
        info.put("vmTotal", vmTotal + "MB");
        info.put("vmUse", vmUse + "MB");
        info.put("threadNum", getThreadNum() + "个");

        return info;
    }

    public static int getThreadNum() {
        ThreadGroup parentThread;
        int totalThread = 0;
        for (parentThread = Thread.currentThread().getThreadGroup(); parentThread.getParent() != null; parentThread = parentThread.getParent()) {
            totalThread = parentThread.activeCount();
        }

        return totalThread;
    }

}
