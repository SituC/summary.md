/**
 * 真题描述：给定一个排序链表，
 * 删除所有含有重复数字的结点，只保留原始链表中 没有重复出现的数字。
 * 输入: 1->2->3->3->4->4->5
  输出: 1->2->5
  示例 2:
  输入: 1->1->1->2->3
  输出: 2->3
 */

function sort(head) {
  if (!head || !head.next) {
    return head
  }
  let dummy = new ListNode()
  dummy.next = head // dummy永远指向头节点
  let cur = dummy
  // cur后面至少有两个结点时
  while(cur.next && cur.next.next) {
    // 比较后面两个结点
    if (cur.next.val === cur.next.next.val) {
      // 重复则记下这个值
      let val = cur.next.val
      // 反复排查后面的元素是否存在多次重复情况
      while(cur.next && cur.next.val === val) {
        // 若有，则删除
        cur.next = cur.next.next
      }
    } else {
      cur = cur.next
    }
    return dummy.next
  }
}