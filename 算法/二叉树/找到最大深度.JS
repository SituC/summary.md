/**
 * Definition for a binary tree node.
 * function TreeNode(val, left, right) {
 *     this.val = (val===undefined ? 0 : val)
 *     this.left = (left===undefined ? null : left)
 *     this.right = (right===undefined ? null : right)
 * }
 */
/**
 * @param {TreeNode} root
 * @return {number}
 */
var maxDepth = function (root) {
    let maxdep = 0
    const dfs = (n, l) => {
        if (!n) { return; }
        if (!n.left && !n.right) {
            maxdep = Math.max(maxdep, l)
        }
        dfs(n.left, l + 1);
        dfs(n.right, l + 1);
    }
    dfs(root, 1)
    return maxdep
};