import { TaskItemDeleteComponent } from './task-item-delete/task-item-delete.component';
import { TaskItem } from '../../model/task_item';
import { Component, OnInit, Input, Output, EventEmitter } from '@angular/core';
import { ApiService } from '../../shared/services/api/api.service';
import { HttpErrorResponse } from '@angular/common/http';
import { MatDialog } from '@angular/material/dialog';

@Component({
  selector: 'app-task-item-show',
  templateUrl: './task-item-show.component.html',
  styleUrls: ['./task-item-show.component.css'],
})
export class TaskItemShowComponent implements OnInit {
  @Input() taskItem: TaskItem;

  constructor(private api: ApiService, public dialog: MatDialog) {}

  ngOnInit(): void {}

  @Output('onDeleteTaskItem') onDeleteTaskItem: EventEmitter<
    any
  > = new EventEmitter();

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

  openDialog(): void {
    const deleteDialogRef = this.dialog.open(TaskItemDeleteComponent, {
      width: '250px',
      data: this.taskItem,
    });

    deleteDialogRef.afterClosed().subscribe((result) => {
      if (result?.delete) {
        this.onDeleteTaskItem.emit();
        console.log('delete');
      } else if (result?.error) {
        console.log('error');
      }
    });
  }
}
