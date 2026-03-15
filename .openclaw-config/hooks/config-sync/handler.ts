/**
 * Config Sync Hook - 自动同步配置到 GitHub
 * 触发: command:new, command:reset
 */
import { exec } from 'child_process';
import { promisify } from 'util';

const execAsync = promisify(exec);

const handler = async (event: any) => {
  // 只处理 new 和 reset 命令
  if (event.type !== 'command' || !['new', 'reset'].includes(event.action)) {
    return;
  }

  console.log('[config-sync] 同步配置到 GitHub...');

  try {
    const { stdout, stderr } = await execAsync('/usr/local/bin/sync-config-to-github', {
      timeout: 60000,
      env: { ...process.env, PATH: '/root/.local/bin:/usr/local/bin:/usr/bin:/bin' }
    });
    
    if (stdout) console.log(stdout);
    if (stderr) console.error(stderr);
    
    console.log('[config-sync] ✅ 同步完成');
  } catch (error) {
    console.error('[config-sync] ❌ 同步失败:', error);
    // 不抛出错误，让其他 hooks 继续
  }
};

export default handler;