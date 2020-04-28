import { TaskItemDeleteComponent } from './task-item-delete/task-item-delete.component';
import { TaskItem } from '../../model/task_item';
import { Component, OnInit, Input, Inject } from '@angular/core';
import { ApiService } from '../../shared/services/api/api.service';
import { HttpErrorResponse } from '@angular/common/http';
import {
  MatDialog,
  MatDialogRef,
  MAT_DIALOG_DATA,
} from '@angular/material/dialog';

@Component({
  selector: 'app-task-item-show',
  templateUrl: './task-item-show.component.html',
  styleUrls: ['./task-item-show.component.css'],
})
export class TaskItemShowComponent implements OnInit {
  @Input() taskItem: TaskItem;

  constructor(private api: ApiService, public dialog: MatDialog) {}

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
  openDialog(): void {
    const dialogRef = this.dialog.open(TaskItemDeleteComponent, {
      width: '250px',
      data: { name: 'this.nam', animal: 'this.animal' },
    });

    dialogRef.afterClosed().subscribe((result) => {
      console.log('The dialog was closed');
    });
  }
}
