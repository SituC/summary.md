/**
 * 
给你一个大小为 m x n 的二进制矩阵 grid 。

岛屿 是由一些相邻的 1 (代表土地) 构成的组合，这里的「相邻」要求两个 1 必须在 水平或者竖直的四个方向上 相邻。你可以假设 grid 的四个边缘都被 0（代表水）包围着。

岛屿的面积是岛上值为 1 的单元格的数目。

计算并返回 grid 中最大的岛屿面积。如果没有岛屿，则返回面积为 0 。

 */

// 淹没与 (i, j) 相邻的陆地，并返回淹没的陆地面积
const dfs = (grid, i, j) => {
  let m = grid.length,
    n = grid[0].length;
  if (i < 0 || j < 0 || i >= m || j >= n) {
    // 超出索引边界
    return 0;
  }
  if (grid[i][j] == 0) {
    // 已经是海水了
    return 0;
  }
  // 将 (i, j) 变成海水
  grid[i][j] = 0;
  // 淹没上下左右的陆地
  return (
    dfs(grid, i + 1, j) + // 上
    dfs(grid, i - 1, j) + // 下
    dfs(grid, i, j - 1) + // 左
    dfs(grid, i, j + 1) + // 右
    1
  );
};
/**
 * @param {number[][]} grid
 * @return {number}
 */
var maxAreaOfIsland = function (grid) {
  let m = grid.length,
    n = grid[0].length;
  // 记录岛屿的最大面积
  let count = 0;
  for (let i = 0; i < m; i++) {
    for (let j = 0; j < n; j++) {
      if (grid[i][j] == 1) {
        // 淹没岛屿，并更新最大岛屿面积
        count = Math.max(count, dfs(grid, i, j));
      }
    }
  }
  return count;
};
