import { TaskItem } from '../model/task_item';
import { Component, OnInit, Input } from '@angular/core';
import { ApiService } from '../shared/services/api/api.service';
import { HttpErrorResponse } from '@angular/common/http';

@Component({
  selector: 'app-task-item-show',
  templateUrl: './task-item-show.component.html',
  styleUrls: ['./task-item-show.component.css'],
})
export class TaskItemShowComponent implements OnInit {
  @Input() taskItem: TaskItem;

  constructor(private api: ApiService) {}

  ngOnInit(): void {}
  handleSuccess(response): void {
    console.log(response);
  }

  handleFail(error: HttpErrorResponse): void {
    console.log(error);
  }

  update(): void {
    this.api
      .updateTaskItem(this.taskItem)
      .subscribe((response) => this.handleSuccess(response), this.handleFail);
  }
}
