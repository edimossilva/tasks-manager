import { TaskitemStoreService } from './../../shared/services/taskitem/taskitem-store.service';
import { Tasklist } from 'src/app/model/tasklist';
import { TaskItem } from '../../model/task_item';
import { Component, OnInit, Input } from '@angular/core';

@Component({
  selector: 'app-task-item-list',
  templateUrl: './task-item-list.component.html',
  styleUrls: ['./task-item-list.component.css'],
})
export class TaskItemListComponent implements OnInit {
  constructor(public taskitemStore: TaskitemStoreService) {}

  @Input() tasklist: Tasklist;
  ngOnInit(): void {}

  removeTaskItem(taskItem: TaskItem): void {
    this.taskitemStore.removeFromTaskList(taskItem);
  }
}
