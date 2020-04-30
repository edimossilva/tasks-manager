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
  constructor(private api: ApiService) {}
  tasklists: Tasklist[];

  handleSuccessOnTaskLists(response): void {
    this.tasklists = response.data.map((tasklist) => new Tasklist(tasklist));
    console.log(this.tasklists[0].frequenceType);
  }

  handleSuccessOnTaskList(tasklist, response): void {
    const taskItems = response.data.task_in_lists.map(
      (taskItem) => new TaskItem(taskItem, tasklist)
    );
    tasklist.taskItems = taskItems;
  }

  handleSuccessDeleteTaskList(tasklist: Tasklist) {
    const index = this.tasklists.indexOf(tasklist, 0);
    if (index > -1) {
      this.tasklists.splice(index, 1);
    } else {
      console.error(`${tasklist} not found`);
    }
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
