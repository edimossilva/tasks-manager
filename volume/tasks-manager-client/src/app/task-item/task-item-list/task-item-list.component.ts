import { Tasklist } from 'src/app/model/tasklist';
import { TaskItem } from '../../model/task_item';
import { Component, OnInit, Input } from '@angular/core';

@Component({
  selector: 'app-task-item-list',
  templateUrl: './task-item-list.component.html',
  styleUrls: ['./task-item-list.component.css'],
})
export class TaskItemListComponent implements OnInit {
  constructor() {}

  @Input() tasklist: Tasklist;
  ngOnInit(): void {}

  removeTaskItem(taskItem: TaskItem): void {
    const index = this.tasklist.taskItems.indexOf(taskItem, 0);
    if (index > -1) {
      this.tasklist.taskItems.splice(index, 1);
    } else {
      console.error(`${taskItem} not found`);
    }
  }

  addTaskItem(taskItemJson: any): void {
    const taskItem = new TaskItem(taskItemJson, this.tasklist);

    this.tasklist.taskItems.push(taskItem);
  }
}
