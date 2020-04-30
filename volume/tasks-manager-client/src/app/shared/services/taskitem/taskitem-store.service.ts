import { Tasklist } from 'src/app/model/tasklist';
import { TasklistStoreService } from './../tasklist/tasklist-store.service';
import { Injectable } from '@angular/core';
import { TaskItem } from 'src/app/model/task_item';

@Injectable({
  providedIn: 'root',
})
export class TaskitemStoreService {
  constructor(private tasklistStoreService: TasklistStoreService) {}

  remove(taskItem: TaskItem) {}
  save(tasklistId: number, taskItemJson: any) {
    let tasklist = this.tasklistStoreService.getTasklist(tasklistId);

    tasklist.taskItems.push(new TaskItem(taskItemJson, tasklist));
  }

  removeFromTaskList(taskItem: TaskItem) {
    let tasklist = this.tasklistStoreService.getTasklist(taskItem.tasklist.id);

    const index = tasklist.taskItems.indexOf(taskItem, 0);
    if (index > -1) {
      tasklist.taskItems.splice(index, 1);
    } else {
      console.error(`${this} not found`);
    }
  }
}
