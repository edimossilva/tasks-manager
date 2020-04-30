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
}
