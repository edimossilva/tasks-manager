import { Component, OnInit } from '@angular/core';
import { Tasklist } from '../../model/tasklist';
import { ApiService } from '../../shared/services/api/api.service';
import { HttpErrorResponse } from '@angular/common/http';
import { MatDialog } from '@angular/material/dialog';
import { TasklistCreateDialogComponent } from './tasklist-create-dialog/tasklist-create-dialog.component';

@Component({
  selector: 'app-tasklist-create',
  templateUrl: './tasklist-create.component.html',
  styleUrls: ['./tasklist-create.component.css'],
})
export class TasklistCreateComponent implements OnInit {
  tasklist: Tasklist = <Tasklist>{};

  constructor(private api: ApiService, public dialog: MatDialog) {}
  ngOnInit(): void {}

  openCreateTaskItemDialog(): void {
    this.dialog.open(TasklistCreateDialogComponent, {
      width: '250px',
      data: this.tasklist,
    });
  }
}
