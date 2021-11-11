/**
 * 真题描述：将两个有序链表合并为一个新的有序链表并返回。
 * 新链表是通过拼接给定的两个链表的所有结点组成的。 
 */

function merge(linked1, linked2) {
  const head = new ListNode() // 定义一个新的链表存放结点
  let newLinked = head
  while(linked1 && linked2) {
    if (linked1.val >= linked2.val) {
      newLinked.next = linked2
      linked2 = linked2.next
    } else {
      newLinked.next = linked1
      linked1 = linked1.next
    }
    newLinked = newLinked.next
  }
  newLinked.next = linked1 === null ? linked2 : linked1
  return head.next
}