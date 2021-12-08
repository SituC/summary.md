// 先序
function xxx(root) {
    if (!root) return []
    let stack = [root]
    const res = []
    while(stack.length) {
        let cur = stack.pop()
        res.push(cur.val)
        if (cur.right) {
            stack.push(cur.right)
        }
        if (cur.left) {
            stack.push(cur.left)
        }
    }
    return stack
}

// 后序
function yy(root) {
    if (!root) return []
    let stack = [root]
    const res = []
    while(stack.length) {
        const cur = stack.pop()
        res.unshift(cur.val)
        if (cur.left) {
            stack.push(cur.left)
        }
        if (cur.right) {
            stack.push(cur.right)
        }
    }
    return res
}
// 中序
function kk(root) {
    if (!root) return []
    let stack = [root]
    const res = []
    let cur = root
    while(cur || stack.length) {
        // 记录所有左节点
        while(cur) {
            stack.push(cur)
            cur = cur.left
        }
        cur = stack.pop()
        res.push(cur.val)
        cur = cur.right
    }
    return res
}

function xx(root) {    
    const res = []
    const stack = [root]
    let cur = root
    while(stack.length || cur) {
        while(cur) {
            stack.push(cur)
            cur = cur.left
        }
        cur = stack.pop()
        res.push(cur.val)
        cur = cur.right
    }
    return res
    
}

function kkkk(root) {
    let cur = root
    let stack = []
    let res = []
    while(cur || stack.length) {
        while(cur) {
            stack.push(cur)
            cur = cur.left
        }
        cur = stack.pop()
        res.push(cur.val)
        cur = cur.right
    }
    return res
}

function bbb(root) {
    let flag = true
    function dfs(root) {
        if(!root || !flag) {
            return 0 
        }
        let left = dfs(root.left)
        let right = dfs(root.right)
        if (Math.abs(left - right) > 1) {
            flag = false
            return 0
        }
        return Math.max(left, right) + 1
    }
    dfs(root)
    return flag
}