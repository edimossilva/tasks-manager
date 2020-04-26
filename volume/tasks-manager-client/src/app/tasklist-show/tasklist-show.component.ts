import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { ApiService } from '../shared/services/api/api.service';
import { HttpErrorResponse } from '@angular/common/http';

@Component({
  selector: 'app-tasklist-show',
  templateUrl: './tasklist-show.component.html',
  styleUrls: ['./tasklist-show.component.css'],
})
export class TasklistShowComponent implements OnInit {
  constructor(private route: ActivatedRoute, private api: ApiService) {}
  handleSuccess(response): void {
    console.log(response);
  }

  handleFail(error: HttpErrorResponse): void {
    console.log(error.error.error_message);
  }

  ngOnInit(): void {
    const id = +this.route.snapshot.paramMap.get('id');
    this.api
      .getTaskList(id)
      .subscribe((response) => this.handleSuccess(response), this.handleFail);
  }
}
