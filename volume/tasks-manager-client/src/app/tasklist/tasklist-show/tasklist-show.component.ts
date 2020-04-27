import { Component, OnInit, Input } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { ApiService } from '../../shared/services/api/api.service';
import { HttpErrorResponse } from '@angular/common/http';
import { Tasklist } from '../../model/tasklist';

@Component({
  selector: 'app-tasklist-show',
  templateUrl: './tasklist-show.component.html',
  styleUrls: ['./tasklist-show.component.css'],
})
export class TasklistShowComponent implements OnInit {
  constructor(private route: ActivatedRoute, private api: ApiService) {}

  tasklist: Tasklist;
  @Input() tasklistId: number;

  handleSuccess(response): void {
    this.tasklist = new Tasklist(response.data);
    console.log(this.tasklist);
  }

  handleFail(error: HttpErrorResponse): void {
    console.log(error.error.error_message);
  }

  ngOnInit(): void {
    const id = this.tasklistId || +this.route.snapshot.paramMap.get('id');
    this.api
      .getTaskList(id)
      .subscribe((response) => this.handleSuccess(response), this.handleFail);
  }
}
