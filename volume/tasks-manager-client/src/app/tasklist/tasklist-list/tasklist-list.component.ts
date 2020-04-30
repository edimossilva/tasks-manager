import { TasklistStoreService } from './../../shared/services/tasklist/tasklist-store.service';
import { Tasklist } from 'src/app/model/tasklist';
import { Component, OnInit } from '@angular/core';
import { ApiService } from '../../shared/services/api/api.service';
import { HttpErrorResponse } from '@angular/common/http';
import { TaskItem } from 'src/app/model/task_item';

@Component({
  selector: 'app-tasklist-list',
  templateUrl: './tasklist-list.component.html',
  styleUrls: ['./tasklist-list.component.css'],
})
export class TasklistListComponent implements OnInit {
  constructor(
    private api: ApiService,
    public tasklistStore: TasklistStoreService
  ) {}
  tasklists: Tasklist[];

  handleSuccessOnTaskLists(response): void {
    const tasklists = response.data.map((tasklist) => new Tasklist(tasklist));
    this.tasklistStore.tasklists = tasklists;
    this.tasklists = this.tasklistStore.tasklists;
  }

  handleSuccessOnTaskList(tasklist, response): void {
    const taskItems = response.data.task_in_lists.map(
      (taskItem) => new TaskItem(taskItem, tasklist)
    );
    tasklist.taskItems = taskItems;
  }

  handleSuccessDeleteTaskList(tasklist: Tasklist) {
    this.tasklistStore.removeTasklist(tasklist.id);
  }

  handleFail(error: HttpErrorResponse): void {
    console.log(error.error.error_message);
  }

  ngOnInit(): void {
    this.api
      .getTaskLists()
      .subscribe(
        (response) => this.handleSuccessOnTaskLists(response),
        this.handleFail
      );
  }

  loadTaskItems(tasklist: Tasklist): void {
    this.api
      .getTaskList(tasklist.id)
      .subscribe(
        (response) => this.handleSuccessOnTaskList(tasklist, response),
        this.handleFail
      );
  }

  deleteTaskList(tasklist: Tasklist): void {
    this.api
      .deleteTaskList(tasklist.id)
      .subscribe(
        (response) => this.handleSuccessDeleteTaskList(tasklist),
        this.handleFail
      );
  }

  trackByFn(index) {
    if (this.tasklists) {
      return this.tasklists[index].id;
    }
  }
}
